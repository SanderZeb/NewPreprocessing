function semNAN = semNAN(x)
    semNAN = std(x, 'omitnan')/sqrt(sum(~isnan(x)));
end