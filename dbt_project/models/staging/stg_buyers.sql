{{config(materialized="view")}}

select
    *
from {{ ref('buyers') }}
