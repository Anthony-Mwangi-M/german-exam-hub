-- Make sure placement test questions are publicly readable
DROP POLICY IF EXISTS "Anyone can view placement test questions" ON placement_test_questions;

CREATE POLICY "Anyone can view placement test questions" 
ON placement_test_questions 
FOR SELECT 
USING (true);

-- Also ensure authenticated users can view
CREATE POLICY "Authenticated users can view placement questions" 
ON placement_test_questions 
FOR SELECT 
TO authenticated
USING (true);
