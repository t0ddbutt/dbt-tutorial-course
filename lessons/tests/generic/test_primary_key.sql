{#
	This test is basically a "not_null" and "unique"
	rolled into one.

	It fails if a column is NULL or occurs more than once
#}

{% test primary_key(model, column_name) %}

WITH validation AS (
    SELECT
        {{ column_name}} as primary_key
        COUNT(1) as occurrences
    FROM {{model}}
    GROUP BY 1

)

SELECT *

FROM validation
WHERE primary_key IS NULL
or occurrences < 1

{% endtest %}