function CONFLICT_print_section_seperator(title)
remaining_chars = 80 - 2 - length(title); % 2 for the colons

fprintf(repmat('=', 1, 80));
fprintf('\n: %s%s:\n', upper(title), repmat(' ', 1, remaining_chars-1));
fprintf(repmat('=', 1, 80));
fprintf('\n');
end