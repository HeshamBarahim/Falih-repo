import { OtpSender } from './authService';

/** Sends the OTP through the existing WhatsApp HTTP relay. URL and key come from Secret Manager. */
export class WhatsAppSender implements OtpSender {
  constructor(
    private readonly url: string,
    private readonly apiKey: string,
  ) {
    if (!url.startsWith('https://')) {
      throw new Error('WHATSAPP_API_URL must be https:// (OTPs must not travel in cleartext)');
    }
  }

  async send(phone: string, code: string): Promise<void> {
    const res = await fetch(this.url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', accept: 'application/json', 'X-Api-Key': this.apiKey },
      body: JSON.stringify({
        chatId: `967${phone}`,
        reply_to: null,
        text:
          `عزيزي العميل،\nرمز التحقق الخاص بك لتطبيق فالح هو ${code}. يرجى عدم مشاركته مع أي شخص.\n` +
          `يظل الرمز صالحًا لمدة 5 دقائق.\n\nشكرًا لاستخدامك تطبيق فالح! 🚀`,
        linkPreview: false,
        session: 'default',
      }),
      signal: AbortSignal.timeout(15_000),
    });
    if (!res.ok) throw new Error(`relay responded ${res.status}`);
  }
}
