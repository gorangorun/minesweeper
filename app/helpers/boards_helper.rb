# frozen_string_literal: true

module BoardsHelper
  def draw_board(matrix)
    fields = []

    matrix.each_with_index do |cells, index|
      fields << draw_cells(cells, index)
    end

    content_tag :div, fields.join.html_safe
  end

  def draw_cells(cells, index)
    content_tag(:div, class: 'flex') do
      draw_cell(cells, index)
    end
  end

  def draw_cell(cells, index)
    fields = []

    cells.each_with_index do |cell, i|
      fields << content_tag(
        :div,
        cell_config(cell).symbol,
        class: "m-2 hover:bg-gray-200 cursor-pointer w-[58px] h-[60px] #{cell_config(cell).class}",
        data: { x: index, y: i, action: 'click->gameplay#swipe' }
      ).html_safe
    end

    fields.join.html_safe
  end

  def cell_config(cell)
    return OpenStruct.new(symbol: '□', class: 'text-7xl') unless cell.revealed?

    if cell.mine?
      OpenStruct.new(symbol: '💣', class: 'text-5xl')
    else
      OpenStruct.new(symbol: '✘', class: 'text-7xl')
    end
  end
end
