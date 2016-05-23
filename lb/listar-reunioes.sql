/*
 * Colunas:
 *   meeting ID, nome da sala, criada em, finalizada em, portal (integração), servidor,
 *   máximo de usuários simultâneos, usuários únicos, IP do criado, requisição de criação
 * Ordena por data de criação: reuniões mais recentes no topo.
 */


/* Serão retornados apenas registros entre essas duas datas (@from <= resultado < @until).
   Para retornar todos registros, coloque datas distantes no passado e futuro. */
SET @from = "2016-04-01", @until = "2016-05-01";
/* Filtro pelo nome da sala e por ID. Buscas não exatas, retornam resultados que incluem
   esses valores no nome ou ID (conforme a variável configurada).
   São também "case insensitive", então buscar por "Mconf" é o mesmo que buscar por "MCONF".
   Se ambas variáveis forem configuradas, retorna apenas os registros onde o nome *e* o ID
   batem com os valores configurados.
   Deixe os valores vazios para retornar todos registros. */
SET @name = '';
SET @meetingId = '';

SELECT id,
  meetingId,
  name,
  createdAt,
  endedAt,
  SUBSTRING(
    integrationStr,
    LOCATE('"name":"', integrationStr) + 8,
    LOCATE('"', integrationStr, (LOCATE('"name":"', integrationStr) + 8)) - (LOCATE('"name":"', integrationStr) + 8)
  ),
  SUBSTRING(
    serverStr,
    LOCATE('"name":"', serverStr) + 8,
    LOCATE('"', serverStr, (LOCATE('"name":"', serverStr) + 8)) - (LOCATE('"name":"', serverStr) + 8)
  ),
  maxUsers,
  uniqueUsers,
  userIP,
  requestQuery
FROM MeetingEvents
WHERE createdAt >= @from AND createdAt < @until AND
      name LIKE CONCAT('%', @name, '%') AND
      meetingId LIKE CONCAT('%', @meetingId, '%')
ORDER BY createdAt DESC
