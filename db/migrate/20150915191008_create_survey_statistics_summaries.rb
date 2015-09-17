class CreateSurveyStatisticsSummaries < ActiveRecord::Migration
def up
    execute <<-SQL
      CREATE VIEW survey_statistics_summaries AS
        SELECT
          lectures.id as lecture_id,
          lectures.name as lecture_name,
          CAST(  concat(CAST('0',AVG(scores.general_score) AS text), CAST(AVG(score_archives.general_score) AS text)) AS numeric(4,3)  ) AS general_score,
          CAST(  concat(CAST('0',AVG(scores.tempo_score) AS text), CAST(AVG(score_archives.tempo_score) AS text)) AS numeric(4,3)  ) AS tempo_score,
          CAST(  concat(CAST('0',AVG(scores.importance_score) AS text), CAST(AVG(score_archives.importance_score) AS text)) AS numeric(4,3)  ) AS importance_score

        FROM
        
          lectures
          LEFT JOIN surveys ON lectures.id = surveys.lecture_id
            LEFT JOIN scores ON surveys.id = scores.id_survey
      LEFT JOIN score_archives ON lectures.id = score_archives.lecture_id
      GROUP BY
      lectures.id

    SQL
  end

  def down
        execute "DROP VIEW survey_statistics_summary"
  end
end