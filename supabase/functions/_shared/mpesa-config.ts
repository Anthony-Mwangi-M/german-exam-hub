// M-Pesa API Configuration
export const getMpesaConfig = () => {
  const environment = Deno.env.get('MPESA_ENVIRONMENT') || 'sandbox';
  const isSandbox = environment === 'sandbox';

  return {
    consumerKey: Deno.env.get('MPESA_CONSUMER_KEY') ?? '',
    consumerSecret: Deno.env.get('MPESA_CONSUMER_SECRET') ?? '',
    shortcode: Deno.env.get('MPESA_SHORTCODE') ?? '',
    passkey: Deno.env.get('MPESA_PASSKEY') ?? '',
    environment,
    baseUrl: isSandbox 
      ? 'https://sandbox.safaricom.co.ke' 
      : 'https://api.safaricom.co.ke',
  };
};

export const getMpesaAccessToken = async () => {
  const config = getMpesaConfig();
  const auth = btoa(`${config.consumerKey}:${config.consumerSecret}`);

  const response = await fetch(
    `${config.baseUrl}/oauth/v1/generate?grant_type=client_credentials`,
    {
      headers: {
        'Authorization': `Basic ${auth}`,
      },
    }
  );

  if (!response.ok) {
    throw new Error('Failed to get M-Pesa access token');
  }

  const data = await response.json();
  return data.access_token;
};

export const formatPhoneNumber = (phone: string): string => {
  // Remove all spaces and special characters
  let formatted = phone.replace(/\s/g, '').replace(/[^0-9]/g, '');
  
  // Convert to 254 format
  if (formatted.startsWith('0')) {
    formatted = '254' + formatted.substring(1);
  } else if (formatted.startsWith('+254')) {
    formatted = formatted.substring(1);
  } else if (!formatted.startsWith('254')) {
    formatted = '254' + formatted;
  }
  
  return formatted;
};

export const generatePassword = (shortcode: string, passkey: string, timestamp: string): string => {
  return btoa(`${shortcode}${passkey}${timestamp}`);
};

export const getTimestamp = (): string => {
  return new Date().toISOString().replace(/[^0-9]/g, '').slice(0, 14);
};
