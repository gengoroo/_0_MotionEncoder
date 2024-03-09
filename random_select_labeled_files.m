function [List_fn_mov_cat, List_pn_mov_cat] = random_select_labeled_files(ListFNPN,n_pick,randstate)

    % select equal random number files from the list of LabelX_filename .......

        ListCell = struct2cell(ListFNPN);
        List_fn = ListCell(1,:);

        ListDelitemp = strfind(List_fn, '_');
        ListDeli = cellfun(@(x) x(1), ListDelitemp);
        Labels = categorical(cellfun(@(x) x(1:ListDeli-1), List_fn, 'UniformOutput', false));
        LabelUni = unique(Labels);
        for id_label = 1:numel(LabelUni)
            ListFnID{id_label} = find(Labels == LabelUni(id_label));
            N = numel(ListFnID{id_label});
            rand('state',randstate);
            ListSelFnID{id_label} = ListFnID{id_label}(randperm(N, n_pick));
            ListSelFn{id_label} = ListFNPN(ListSelFnID{id_label});
        end

        data = {cat(1,ListSelFn{:})};
        data2 = struct2cell(data{1});
        List_pn_mov_cat = data2(2,:);
        List_fn_mov_cat = data2(1,:);

end