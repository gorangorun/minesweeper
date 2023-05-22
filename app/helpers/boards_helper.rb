# frozen_string_literal: true

module BoardsHelper
  def draw_board(matrix)
    fields = []

    matrix.each_with_index do |cells, y|
      fields << draw_cells(cells, y)
    end

    content_tag :div, fields.join.html_safe
  end

  # rubocop:disable Naming/MethodParameterName
  def draw_cells(cells, y)
    content_tag(:div, class: 'flex') do
      draw_cell(cells, y)
    end
  end

  # rubocop:disable Layout/LineLength
  def draw_cell(cells, y)
    fields = []

    cells.each_with_index do |cell, x|
      config = cell_config(cell)
      fields << content_tag(
        :div,
        config.symbol,
        class: "flex justify-center text-5xl bg-gray-300 hover:bg-gray-200 items-center cursor-pointer w-[74px] h-[74px] #{config.class}",
        style: config.style,
        data: { y:, x:, action: 'click->gameplay#swipe' }
      ).html_safe
    end

    fields.join.html_safe
  end
  # rubocop:enable Layout/LineLength
  # rubocop:enable Naming/MethodParameterName

  def cell_config(cell)
    return OpenStruct.new(symbol: '', class: '', style: 'border: 6px outset #ececec') unless cell.revealed?

    if cell.mine?
      OpenStruct.new(symbol: '💣', class: '')
    else
      OpenStruct.new(symbol: cell.value, class: '')
    end
  end
end
