require 'RMagick'
include Magick

module Gasket

    WIDTH = 500
    HEIGHT = 500
    def self.make_gasket
        image = Image.new(WIDTH, HEIGHT)
        gc = Draw.new.stroke('green').fill('white')
        Gasket.new(gc).print()
        gc.draw(image)
        image.write('gasket.jpg')
    end

    class Gasket
        def initialize(draw)
            @draw = draw
        end

        def print
            width = Gasket::Gasket::WIDTH - 70 # 三角形の底辺の長さを設定
            xSift = 10             # x座標のシフト
            ySift = 50            # y座標のシフト
            @draw.polygon(xSift, width + ySift, width + xSift, width + ySift, width / 2 + xSift, ySift)
            draw_triangle(3, [xSift, width + xSift, width / 2 + xSift], [width + ySift, width + ySift, ySift] )
        end


        def draw_triangle(times, x, y)

            if (times < 1) 
                return  # 繰り返しが1未満なら終了
            end

            ## 各辺の中点を結んだ三角形の描画 */
            x1 = [(x[0] + x[1]) / 2, (x[1] + x[2]) / 2, (x[2] + x[0]) / 2]
            y1 = [(y[0] + y[1]) / 2, (y[1] + y[2]) / 2, (y[2] + y[0]) / 2]
            @draw.polygon((x[0] + x[1]) / 2, (y[0] + y[1]) / 2, (x[1] + x[2]) / 2, (y[1] + y[2]) / 2, (x[2] + x[0]) / 2, (y[2] + y[0]) / 2)

            ## 真ん中以外の三角形に対して繰り返し三角形を描画 */
            x2 = [x1[0], x[1], x1[1]]
            y2 = [y1[0], y[1], y1[1]]
            draw_triangle( times - 1, x2, y2); # 三角形描画の再帰呼び出し

            x2 = [x1[2], x1[1], x[2]]
            y2 = [y1[2], y1[1], y[2]]
            draw_triangle( times - 1, x2, y2); # 三角形描画の再帰呼び出し

            x2 = [x[0], x1[0], x1[2]]
            y2 = [y[0], y1[0], y1[2]]
            draw_triangle( times - 1, x2, y2); # 三角形描画の再帰呼び出し
        end

    end
end
