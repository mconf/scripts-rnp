SET @from = "2016-04-01", @until = "2016-05-01";

SELECT meetingID as "meetingID",
       name AS "name",
       COUNT(id) AS "aggMeetings",
       SUM(uniqueUsers) AS "aggUniqueUsers",
       AVG(uniqueUsers) AS "avgUniqueUsers",
       MAX(maxUsers) AS "maxUsers",
       AVG(maxUsers) AS "avgMaxUsers",
       SUM(TIMESTAMPDIFF(MINUTE, createdAt, endedAt)) AS "aggDuration (min)",
       AVG(TIMESTAMPDIFF(MINUTE, createdAt, endedAt)) AS "avgDuration (min)"
FROM MeetingEvents
WHERE maxUsers > 1
AND createdAt >= @from AND createdAt < @until
AND integration = 2
GROUP BY meetingID
ORDER BY name;
