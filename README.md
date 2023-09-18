# Counter-Strike 1.6 Server Docker Image

## Iniciar com Docker Compose

``` bash
docker compose -f compose.yml up -d --build
```

## Variáveis de Ambiente

| Variable   | Value    |
| ---------- | -------- |
| PORT       | 27015    |
| MAP        | de_dust2 |
| MAXPLAYERS | 16       |
| SV_LAN     | 0        |

## Arquivos de Configuração

Você pode adicionar seu `server.cfg`, `banned.cfg`, `listip.cfg` e `mapcycle.txt`.

Tenha em mente que o arquivo `server.cfg` pode substituir as configurações de suas variáveis de ambiente:  
`MAP`, `MAXPLAYERS` and `SV_LAN`

### Exemplo de server.cfg

```
// Use this file to configure your DEDICATED server.
// This config file is executed on server start.

// disable autoaim
sv_aim 0

// disable clients' ability to pause the server
pausable 0

// default server name. Change to "Bob's Server", etc.
hostname "Counter-Strike 1.6 Server"

// RCON password
rcon_password "password"

// default map
map de_dust2

// maximum client movement speed
sv_maxspeed 320

// 20 minute timelimit
mp_timelimit 20

// disable cheats
sv_cheats 0

// load ban files
exec listip.cfg
exec banned.cfg
```
