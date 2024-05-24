const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://your-project.supabase.co';
const supabaseAnonKey = 'your-anon-key';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function getAccessToken() {
  const { data, error } = await supabase.auth.getSession();
  if (error) {
    console.error('Error getting session:', error);
    process.exit(1);
  }
  const accessToken = data.session?.access_token;
  console.log(accessToken);
}

getAccessToken();
