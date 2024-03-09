function fn_hit = find_partial_match_file(fn, List_fn, varargin)
    for ii = 1:nargin-2
        if strcmp(varargin{ii},'included')
            matchtype = 'included';
        end
        if strcmp(varargin{ii},'include')
            matchtype = 'include';
        end
    end

    for id_file_list = 1:numel(List_fn)
        switch matchtype
            case 'include'
                ID_hit = find(~cellfun(@isempty,strfind(List_fn,fn)));
            case 'included'
                ID_hit = find(cellfun(@(x) ~isempty(strfind(fn, x)),List_fn));
        end
    end

    fn_hit = List_fn{ID_hit};

    if numel(ID_hit) ~= 1
        fprintf('n hit files is %d\n',numel(ID_hit));
    end
    
end