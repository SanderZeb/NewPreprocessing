function [idx] = clear_dataset(current_behawior, current_alpha)
      index_behawior = 1;
      s = 1;
      for index_alpha = 1:size(current_alpha, 1)

        if current_alpha.type(index_alpha) == current_behawior.trigger(index_behawior)
            idx(s) = 0;
        else
            idx(s) = 1;
            break
        end
      end

end