class CreateSurveyStatisticsSummaries < ActiveRecord::Migration
def up
    execute <<-SQL
      CREATE VIEW survey_statistics_summaries AS
         SELECT lectures.id AS lecture_id,
          lectures.name AS lecture_name,
          concat('0', avg(scores.general_score)::text, avg(score_archives.general_score)::text)::numeric(4,3) AS general_score,
          concat('0', avg(scores.tempo_score)::text, avg(score_archives.tempo_score)::text)::numeric(4,3) AS tempo_score,
          concat('0', avg(scores.importance_score)::text, avg(score_archives.importance_score)::text)::numeric(4,3) AS importance_score,
          concat('0', count(scores.general_score)::text, avg(score_archives.number_of_votes)::text)::integer AS number_of_votes
         FROM lectures
           LEFT JOIN surveys ON lectures.id = surveys.lecture_id
           LEFT JOIN scores ON surveys.id = scores.id_survey
           LEFT JOIN score_archives ON lectures.id = score_archives.lecture_id
        GROUP BY lectures.id

    SQL
  end

  def down
        execute "DROP VIEW survey_statistics_summary"
  end
end