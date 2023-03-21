-- Creating function that retrieves all addresses containing the number "11"
-- and with a city_id between 400 and 600
CREATE OR REPLACE FUNCTION get_addresses_special()
    RETURNS TABLE (addr_id integer, addr1 varchar, addr2 varchar, zipcode varchar) AS $$
BEGIN
    RETURN QUERY
        SELECT address_id, address, address2, postal_code
        FROM address addr
        WHERE addr.address LIKE '%11%' AND addr.city_id BETWEEN 400 AND 600;
END;
$$ LANGUAGE plpgsql;
