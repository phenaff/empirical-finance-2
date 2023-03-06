TrinomialTreePlot <- function (TrinomialTreeValues, dx = -0.025, dy = 0.4, cex = 1, 
    digits = 2,  ...) 
{
    # draw 3 branches originating at node (x,y)
    drawLines <- function(x,y,col=2) {
      xx = c(x,x+1)
      for(k in -1:1) {
        yy = c(y, y+k)
       lines(x=xx,y=yy,col=col)
      }
    }
    Tree = round(TrinomialTreeValues, digits = digits)
    depth = ncol(Tree)
    # frame and coordinates: 
    plot(x = c(1, depth), y = c(-depth+1, depth-1), type = "n", 
        col = 0, yaxt='n', xaxt='n', xlab='step', ylab='', ...)
    axis(1,at=1:depth)
    # tree root
    points(x = 1, y = 0)
    drawLines(1,0)
    text(1 + dx, 0 + dy, deparse(Tree[1, 1]), cex = cex)
    for (i in 1:(depth - 1)) {
        y = seq(from = i, by = -1, length = 2*i + 1)
        x = rep(i, times = length(y)) + 1
        points(x, y, col = 1)
        # place text
        for (j in 1:length(x)) text(x[j] + dx, y[j] + dy, deparse(Tree[j, i + 1]), cex = cex)
           
        if(i<(depth-1)) {
          for (k in 1:length(x)) drawLines(x[k], y[k]) 
        }
    }
    invisible()
}
