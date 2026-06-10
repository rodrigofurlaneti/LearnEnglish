import { useMutation } from '@tanstack/react-query';
import { usersApi } from '../api/users.api';
import type { CreateUserRequest } from '../api/users.api';

export function useCreateUser() {
  return useMutation({
    mutationFn: (body: CreateUserRequest) => usersApi.create(body),
  });
}
