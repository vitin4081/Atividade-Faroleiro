@echo off
title Configurando Ambiente do Aluno
echo ===================================================
echo Identificando aluno automaticamente...
echo ===================================================
:: 1. Pega a URL HTTP do repositório que o aluno acabou de clonar
for /f "tokens=*" %%i in ('git remote get-url origin') do set URL=%%i
:: 2. Extrai o nome de usuário da URL (Pega a 3ª palavra separada por barras)
for /f "tokens=3 delims=/" %%a in ("%URL%") do set ALUNO=%%a
:: Armazena o caminho da pasta atual para a deleção futura
set PASTA_ATUAL=%CD%
:: 3. Configura o Git localmente com o nome extraído
echo.
echo Ola, %ALUNO%! Vinculando este repositorio a sua conta...
git config --local user.name %ALUNO%
git config --local user.email %ALUNO%@ifba.edu.br
git config --local pull.rebase false
:: ===================================================
:: NOVA CONFIGURAÇÃO CORRIGIDA PARA O GERENCIADOR NOVO
:: ===================================================
git config --local credential.helper manager
git config --local credential.credentialStore wincredman
git config --local credential.useHttpPath true
:: ===================================================
git config --local push.default current
cmdkey /delete:LegacyGeneric:target=git:https://refresh_token.s3lab.dpdns.org >nul 2>&1
cmdkey /delete:LegacyGeneric:target=git:https://dpdns.org >nul 2>&1
echo.
echo ===================================================
echo [SUCESSO] Maquina pronta!
echo ===================================================
echo.
:: ===================================================
:: FASE 1: PREPARAÇÃO E COMMIT
:: ===================================================
echo Preparando arquivos para envio...
git add .
echo.
echo Criando commit...
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set dt=%%a
:: Tenta realizar o commit com a data atual
call git commit -m "Envio automatico de atividades - Aluno: %ALUNO% - %dt:~0,4%-%dt:~4,2%-%dt:~6,2% %dt:~8,2%:%dt:~10,2%:%dt:~12,2%"
:: VERIFICAÇÃO INTELIGENTE: Verifica se existem commits locais que ainda não foram enviados
set PRECISA_DE_PUSH=0
for /f "tokens=*" %%i in ('git status -sb') do (
    echo %%i | findstr /C:"ahead" >nul && set PRECISA_DE_PUSH=1
)
:: Se o commit falhou E não há nenhum outro commit antigo para enviar, interrompe o script
if errorlevel 1 (
    if %PRECISA_DE_PUSH% == 0 (
        echo.
        echo [AVISO] Nao ha alteracoes novas e nenhum envio pendente.
        goto FIM
    )
)
:: ===================================================
:: FASE 2: ENVIO (PUSH)
:: ===================================================
echo.
chcp 65001 >nul
echo Enviando o codigo para o Forgejo...
echo [ATENCAO] Se solicitado, faca o login na janela do navegador que se abrira.
echo.
:: Configurações corrigidas para forçar o navegador sem travar o VS Code
set GIT_TERMINAL_PROMPT=0
set GIT_ASKPASS=
set GCM_PROVIDER=generic
:: Executa o push diretamente no terminal atual
git push origin HEAD
:: Se o push falhar (ex: erro de rede ou autenticação recusada), interrompe o script
if errorlevel 1 (
    echo.
    echo [ERRO] Falha ao enviar o codigo para o servidor. A pasta NAO sera deletada.
    goto FIM
)

:: ===================================================
:: NOVO: ABRIR O REPOSITÓRIO NO NAVEGADOR
:: ===================================================
echo.
echo Abrindo o repositorio no seu navegador...
start "" "%URL%"

:: ===================================================
:: FASE 3: DELEÇÃO SE CADA ETAPA ANTERIOR PASSOU
:: ===================================================
echo.
echo ===================================================
echo [SUCESSO] Codigo salvo e enviado com sucesso!
echo Apagando diretorio local para limpar a maquina...
echo ===================================================
echo.
:: Pequena pausa para garantir que nenhum processo do Git ainda segure os arquivos
timeout /t 3 /nobreak >nul
:: Sai da pasta atual para liberar o bloqueio do Windows e deleta o diretório
cd ..
rd /s /q "%PASTA_ATUAL%"
:: Fecha o terminal automaticamente após apagar tudo com sucesso
exit

:FIM
echo.
pause
