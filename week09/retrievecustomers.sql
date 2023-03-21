-- Function that retrieves customers ordered by their "address_id",
-- with two parameters, "start" and "end".
-- For example, calling the function with "retrievecustomers(10, 40)" will retrieve
-- customers starting from the 10th customer in the query and ending with the 40th.

CREATE or REPLACE FUNCTION retrieve_customers(_start INTEGER, _end INTEGER)
    RETURNS SETOF customer AS $$
BEGIN
    IF _start < 0 OR _end > 600 OR _start > _end THEN
        RAISE EXCEPTION 'Invalid start and end parameters';
    END IF;

    RETURN QUERY
        SELECT   *
        FROM     customer c
        ORDER BY address_id
        OFFSET   _start - 1
            LIMIT    _end - _start + 1;
END;
$$ LANGUAGE 'plpgsql';
