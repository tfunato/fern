require "fern/version"
require 'RMagick'
include Magick

module Fern
    WIDTH = 500
    HEIGHT = 500

    def make_fern
        image = Image.new(WIDTH, HEIGHT)
        gc = Draw.new
        gc.fill('green')
        f = F.new(gc)
        f.f(20, 0, 0)
        gc.draw(image)
        image.write('fern.jpg')
    end
    module_function:make_fern

    class F
        def initialize(draw)
            @draw = draw
        end

        def W1x(x, y)
            0.836 * x + 0.044 * y;
        end

        def W1y(x, y)
            -0.044 * x + 0.836 * y + 0.169;
        end

        def W2x(x, y) 
            -0.141 * x + 0.302 * y;
        end

        def W2y(x, y) 
            0.302 * x + 0.141 * y + 0.127;
        end

        def W3x(x, y) 
            0.141 * x - 0.302 * y;
        end

        def W3y(x, y) 
            0.302 * x + 0.141 * y + 0.169;
        end

        def W4x(x, y)
            0;
        end

        def W4y(x, y)
            0.175337 * y;
        end

        def rnd
            Random.new.rand 0..1.0
        end

        def f(k, x, y) 
            if (0 < k) 
                f(k - 1, W1x(x, y), W1y(x, y));
                if (rnd() < 0.3) 
                    f(k - 1, W2x(x, y), W2y(x, y));
                end
                if (rnd() < 0.3)
                    f(k - 1, W3x(x, y), W3y(x, y));
                end 
                if (rnd() < 0.3)
                    f(k - 1, W4x(x, y), W4y(x, y));
                end
             else 
                s = 490;
                @draw.point(x * s + Fern::WIDTH * 0.5, Fern::HEIGHT - y * s);
           end 
        end
    end
end
