select
    user_id,
	profile_data,
	profile_data::json ->> 'name' as name,
	profile_data::json ->> 'email' as email,
	coalesce((profile_data::json -> 'preferences' ->> 'newsletter')::boolean, false) as newsletter,
	created_at
from {{ ref('users') }}