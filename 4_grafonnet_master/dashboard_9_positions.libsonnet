local grid_width = 24;

{
  generate_positions(panels):: [
    el {
      gridPos: {
        x: el.gridPos.x,
        y: el.gridPos.y,
        h: el.gridPos.h,
        w: el.gridPos.w,
      },
    }
    for el in std.foldl(function(_panels, p) (
      local i = std.length(_panels);
      local prev = (if i == 0 then null else _panels[i - 1]);

      if i == 0 then
        _panels + [p { gridPos: {
          x: 0,
          y: 0,
          h: p.gridPos.h,
          w: p.gridPos.w,
          x_cursor: p.gridPos.w,
          y_cursor: 0,
        } }]
      else
        local line_break = prev.gridPos.x_cursor + p.gridPos.w > grid_width;

        _panels + [p { gridPos: {
          x:
            if line_break then
              0
            else
              prev.gridPos.x_cursor,

          y:
            if line_break then
              prev.gridPos.y_cursor + prev.gridPos.h
            else
              prev.gridPos.y_cursor,

          h: p.gridPos.h,

          w: p.gridPos.w,

          x_cursor:
            if line_break then
              p.gridPos.w
            else
              prev.gridPos.x_cursor + p.gridPos.w,

          y_cursor:
            if line_break then
              prev.gridPos.y_cursor + prev.gridPos.h
            else
              prev.gridPos.y_cursor,
        } }]
    ), panels, [])
  ],
}