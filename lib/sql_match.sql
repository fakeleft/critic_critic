select
  id, sum(score)
from (
  select critics.id, 1 as score
  from users
  inner join user_opinions
    on users.id = user_opinions.user_id
  inner join movies
    on user_opinions.movie_id = movies.id
  inner join critic_opinions
    on critic_opinions.movie_id = movies.id
    and user_opinions.like = critic_opinions.like
  inner join critics
    on critic_opinions.critic_id = critics.id
  union all
  select critics.id, -1 as score
  from users
  inner join user_opinions
    on users.id = user_opinions.user_id
  inner join movies
    on user_opinions.movie_id = movies.id
  inner join critic_opinions
    on critic_opinions.movie_id = movies.id
    and user_opinions.like != critic_opinions.like
  inner join critics
  on critic_opinions.critic_id = critics.id
  ) as sub
group by id
order by sum(score) desc
limit 5;
