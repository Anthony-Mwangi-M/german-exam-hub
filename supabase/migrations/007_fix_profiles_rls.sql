-- Drop all existing policies on profiles
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Allow user creation" ON profiles;
DROP POLICY IF EXISTS "Enable insert for authentication" ON profiles;

-- Create a function to check if user is admin (avoids recursion)
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() 
    AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- Recreate policies without recursion
-- Users can view their own profile
CREATE POLICY "Users can view own profile" 
ON profiles 
FOR SELECT 
USING (auth.uid() = id);

-- Users can update their own profile  
CREATE POLICY "Users can update own profile" 
ON profiles 
FOR UPDATE 
USING (auth.uid() = id);

-- Allow profile creation (for the trigger)
CREATE POLICY "Enable insert for authentication" 
ON profiles 
FOR INSERT 
WITH CHECK (true);

-- Note: Admin policies removed to avoid recursion
-- Admins can use service role key for admin operations
