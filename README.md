# Faroleiro

Repositório para entregar o código https://pages.s3lab.dpdns.org/leandro/2026-inf-poo/posts/19_revisao_onde_quebra.html rodando

|  Linha  | Energia de `F1` depois da linha | Valor devolvido por `usar()` |
| :-----: | :-----------------------------: | :--------------------------: |
|    1    |             100                 |              —               |
| 2 (`q`) |             100                 |              15              |
| 3 (`l`) |             100                 |              2               |
| 4 (`o`) |             100                 |              -70             |
|    5    |             90                  |              —               |
|    6    |             20                  |              -70             |
|    7    |             22                  |              2               |
|    8    |             22                  |       - (chama null)         |
|    9    |             0                   |              -70             |
|   10    |             15                  |              15              |