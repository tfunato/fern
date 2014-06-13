require 'RMagick'
include Magick

module Koch
    WIDTH = 500
    HEIGHT = 500

    def self.make_koch
        image = Image.new(WIDTH, HEIGHT)
        gc = Draw.new.fill('green')
        Koch.new(gc).paint()
        gc.draw(image)
        image.write('koch.jpg')
    end

    class Koch
        def initialize(draw)
            @draw = draw
        end
        def paint
            a = Point.new(100, 160)
            b = Point.new(420, 160)
            koch(@draw, a, b, 3)
        end

        def koch(g, a, b, n)

            c = Point.new((2 * a.x + b.x) / 3, (2 * a.y + b.y) / 3)
            d = Point.new((a.x + 2 * b.x) / 3, (a.y + 2 * b.y) / 3)
            xx = b.x - a.x
            yy = -(b.y - a.y)

            distance = Math.sqrt((xx * xx) + (yy * yy)) / Math.sqrt(3)
            if (xx >= 0)
                if (xx == 0)
                    angle1 = Math.atan(0) + Math::PI / 6
                else
                    angle1 = Math.atan(yy / xx) + Math::PI / 6
                end
                e = Point.new( a.x + (distance * Math.cos(angle1)), a.y - (distance * Math.sin(angle1)))
            else 
                angle2 = Math.atan(yy / xx) - Math::PI / 6
                e = Point.new( b.x + (distance * Math.cos(angle2)), b.y - (distance * Math.sin(angle2)))
            end

            if (n <= 0)
                g.line(a.x, a.y, c.x, c.y)
                g.line(c.x, c.y, e.x, e.y)
                g.line(e.x, e.y, d.x, d.y)
                g.line(d.x, d.y, b.x, b.y)
            else
                koch(g, a, c, n - 1)
                koch(g, c, e, n - 1)
                koch(g, e, d, n - 1)
                koch(g, d, b, n - 1)
            end
        end

        class Point
            attr_accessor :x
            attr_accessor :y
            def initialize(x, y)
                @x = x
                @y = y
            end
        end
    end
end
