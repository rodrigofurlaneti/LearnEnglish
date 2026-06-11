import { APIRequestContext } from '@playwright/test';

const API_URL = process.env.API_URL ?? 'http://localhost:5000/api';

export async function createTestUser(request: APIRequestContext, name = 'Test User', email?: string) {
  const uniqueEmail = email ?? `test-${Date.now()}@learnenglish.test`;
  const response = await request.post(`${API_URL}/users`, {
    data: { name, email: uniqueEmail },
  });
  const body = await response.json();
  return { id: body.id as string, name, email: uniqueEmail };
}

export async function getLessons(request: APIRequestContext) {
  const response = await request.get(`${API_URL}/lessons`);
  return response.json();
}

export async function getLessonDetail(request: APIRequestContext, id: string) {
  const response = await request.get(`${API_URL}/lessons/${id}`);
  return response.json();
}
