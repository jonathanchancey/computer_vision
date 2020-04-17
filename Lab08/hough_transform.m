% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

function [m, b] = hough_transform(edge_map, img_name)
    %find x, y position from edge map
    [edge_y, edge_x] = find(edge_map);
    
    % range of b
    H = size(edge_map, 1);
    b_range = -H : 1: H;
    
    % range of m
    m_step = 0.01;
    m_max = 5;
    m_min = -m_max;
    m_range = m_min : m_step : m_max;
    
    % create vote matrix
    V = zeros(length(m_range), length(b_range));
    
    % add votes
    for i = 1 : length(edge_y)
        
        y = edge_y(i);
        x = edge_x(i);
        
%         disp(y);
%         disp(x);

        for b_index = 1 : length(b_range)
            b = b_range(b_index);
            m = -1 / x * b + y / x;
            
            if m_min <= m && m <= m_max 
                m_index = round((m - m_min) / (m_step)) + 1;
                V(m_index, b_index) = V(m_index, b_index) + 1;
            end
        end
    end
    
    %plot votes
    figure, imagesc(V); xlabel('b'); ylabel('m');
    
    % save current plot--it looks cool
    saveas(gcf, sprintf('%s_mb_space.png', img_name)); 
    
    % find the maximal vote
    max_vote = max(V(:));
    [max_m_index, max_b_index] = find(V == max_vote);
    m = m_range(max_m_index);
    b = b_range(max_b_index);
    
end