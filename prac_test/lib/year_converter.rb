class YearConverter
  FIRST_YEAR = {
    "令和" => 2019,
    "平成" => 1989,
    "昭和" => 1926,
    "大正" => 1912,
    "明治" => 1868,
    "慶応" => 1865
  }

  END_YEAR = {
    "平成" => 2019,
    "昭和" => 1989,
    "大正" => 1926,
    "明治" => 1912,
    "慶応" => 1868
  }

  def guess_ad_year(string)
    match = string.match(/^(..)(\d+|元)年$/)

    #不正フォーマットを弾く
    return if !match

    jp_era = match[1]
    jp_year = match[2]

    jp_year = (jp_year == "元") ? 1 : jp_year.to_i

    beginning_year = FIRST_YEAR[jp_era]

    #範囲外の一礼を弾く
    ##非対応年号を弾く
    return if !beginning_year
    ##0年を弾く
    return if jp_year == 0
    ##終了した年号移行の西暦算出を防ぐ
    if jp_era != "令和"
      end_year = END_YEAR[jp_era]
      return if beginning_year + (jp_year - 1) > end_year
    end

    return beginning_year + (jp_year - 1)
  end
end