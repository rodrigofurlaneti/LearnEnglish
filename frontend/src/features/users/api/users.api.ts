import { http } from '../../../core/http/client';
import type { UserDto } from '../../../shared/types';

export interface CreateUserRequest {
  name: string;
  email: string;
}

export const usersApi = {
  create: async (body: CreateUserRequest): Promise<{ id: string }> => {
    const { data } = await http.post<{ id: string }>('/users', body);
    return data;
  },

  getById: async (id: string): Promise<UserDto> => {
    const { data } = await http.get<UserDto>(`/users/${id}`);
    return data;
  },
};
