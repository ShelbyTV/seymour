module  Seymour
  class ScoreHelper

    # Score increases linearly with time, logarithmically with votes
    # 10 votes = 1/2 day worth of points
    # 100 votes = 1 day worth of points
    def update_score
      #each second = .00002
      #each hour = .08
      #each day = 2
      time_score =(self.created_at.to_f - SHELBY_EPOCH.to_f) / TIME_DIVISOR
      like_score = self.calculate_like_score
      self.score = time_score + like_score
    end

    def calculate_like_score
      #+ log10 each like
      # add 1 so that zero likes is zero points and 1 like makes a measurable difference
      # 0 likes = 0 points
      # 1 like = 1 point
      # 10 likes = 2 points
      # 100 likes = 3 points
      [Math.log10(self.like_count), -1.0].max + 1.0
    end

    private


  end
end
