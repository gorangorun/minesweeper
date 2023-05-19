# frozen_string_literal: true

module BoardsHelper
  def draw_board(matrix)
    fields = []

    matrix.each_with_index do |x, index|
      fields << draw_x(x, index)
    end

    content_tag :div, fields.join.html_safe
  end

  def draw_x(x, index)
    content_tag(:div, class: 'flex', id: x) do
      draw_y(x, index)
    end
  end

  def draw_y(x, index)
    fields = []

    x.each_with_index do |y, i|
      fields << content_tag(
        :div,
        value_config(y).symbol,
        class: "m-2 hover:bg-gray-200 cursor-pointer w-[58px] h-[60px] #{value_config(y).class}",
        data: { x: index, y: i, action: 'click->gameplay#swipe' }
      ).html_safe
    end

    fields.join.html_safe
  end

  def value_config(value)
    case value
    when Minesweeper::Board::EMPTY
      OpenStruct.new(symbol: '✘', class: 'text-7xl')
    when Minesweeper::Board::MINE # , Minesweeper::BoardFactory::MINE
      OpenStruct.new(symbol: '💣', class: 'text-5xl')
    else
      OpenStruct.new(symbol: '□', class: 'text-7xl')
    end
  end
end
