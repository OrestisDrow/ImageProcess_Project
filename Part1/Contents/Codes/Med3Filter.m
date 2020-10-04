
    function func = Med3Filter(f)
        dimentions = size(f);
        d1 = dimentions(1); %Rows
        d2 = dimentions(2); %Columns
        shadowImg = zeros(d1, d2);
        
        %Applying mask
        for row = 2:d1 - 1
            for col = 2:d2 - 1
               
                mask = f(row - 1:row + 1, col - 1: col + 1);
                mask = reshape(mask, 1, 9);
                mask = sort(mask);
                shadowImg(row, col) = mask(5);
                
            end
        end
        %By default edges of the picture will not be masked
        shadowImg(1, :) = f(1, :);
        shadowImg(d1, :) = f(d1, :);
        shadowImg(:, 1) = f(: , 1);
        shadowImg(:, d2) = f(: , d2);
        func = shadowImg;
    end