INSERT INTO diet_users (name, target_calories, target_protein, target_fat, target_carbo)
SELECT '初期ユーザー', 2000, 130.0, 60.0, 300.0
WHERE NOT EXISTS (
    SELECT 1 FROM diet_users WHERE name = '初期ユーザー'
);