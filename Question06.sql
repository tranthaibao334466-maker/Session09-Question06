
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    category_id INT
);

-- Insert samples 
INSERT INTO Products (name, price, category_id) VALUES
('Laptop Alpha', 1200.00, 1),
('Mouse T100', 25.00, 1),
('Keyboard M2', 75.00, 1),
('Smartphone X', 800.00, 2),
('Headphones Z', 150.00, 2);

CREATE OR REPLACE PROCEDURE update_product_price(
    p_category_id INT,
    p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Products
    SET price = price * (1 + p_increase_percent / 100)
    WHERE category_id = p_category_id;
END;
$$;

SELECT * FROM Products ORDER BY product_id;

FOR category_record IN SELECT DISTINCT category_id FROM Products
LOOP
    -- Gọi procedure tăng giá 10% cho mỗi category_id
    CALL update_product_price(category_record.category_id, 10);
END LOOP;

SELECT * FROM Products ORDER BY product_id;