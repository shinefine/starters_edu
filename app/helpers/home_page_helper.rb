module HomePageHelper

  def helper__range_block_summary_text(range_blocks)
    #传入[0...50,50...100,100...200]  -----> 返回 ['0分~50分','50分~100分','100分~200分','200分以上']
    arr =range_blocks.map{|r|
      "#{r.begin}分~#{r.end}分"
    }
    r = range_blocks.last
    arr<<  "#{r.end}分以上"
    return arr
  end

  def helper__summary_value_in_which_range(value,range_blocks)
    #描述指定值在哪个范围内
    #range_blocks = [0...50,50...100,100...150,150...200]
    #根据传入的值value,返回值所在区间的描诉
    range_blocks.each{|r|
      if r.include?(value)
        return "#{r.begin}分~#{r.end}分"
      end
    }

    if  value < 0
      r = range_blocks[0]
      return "#{r.begin}分~#{r.end}分"
    end

    r =range_blocks.last
    if value >= r.end
      return "#{r.end}分以上"
    end
  end



end
