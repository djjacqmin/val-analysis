function G = gamma2d (A1, A2, DTA, dosed, X, Y, X1, Y1)
    size1=size (A1) ;
    size2=size (A2) ;
    dosed = dosed *  max(A1 ( : ) ) ; %scale dosed as a percent of the maximum dose
    
    searchRadius = 10; % mm

    G=zeros ( size1 ) ; %this will be the output
    Ga=zeros ( size1 ) ;
    if size1 == size2
        for i = 1 : size1( 1 )         
            if isHere(Y1(i),Y)
                for j = 1 : size1( 2 )
                    if isHere(X1(j),X)
                                               
                        for k = max(1,(i-searchRadius)):min(size1(1),(i+searchRadius))
                            for l = max(1,(j-searchRadius)):min(size1(2),(j+searchRadius))
                                r2 = ( i - k )^2 + (j - l) ^2 ; %distance (radius) squared
                                d2 = ( A1( i , j ) - A2( k , l ) )^2 ; %difference squared
                                Ga( k , l ) = sqrt(r2 / (DTA^2) + d2/ dosed ^ 2);
                            end
                        end
                        G( i , j )=min(min(Ga)) ;
                    end
                end
            
            end
        end
    else
        fprintf('matrices A1 and A2 are do not share the same dimensions! \n');
    end
end


