import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { api } from '../api/client'

export function useCardDetail(cardId: number) {
  return useQuery({
    queryKey: ['cards', cardId],
    queryFn: () => api.getCard(cardId),
    enabled: !!cardId,
  })
}


export function useSets() {
  return useQuery({
    queryKey: ['sets'],
    queryFn: api.getSets,
  })
}

export function useSetCards(setCode: string) {
  return useQuery({
    queryKey: ['sets', setCode, 'cards'],
    queryFn: () => api.getSetCards(setCode),
    enabled: !!setCode,
  })
}

export function useStats() {
  return useQuery({
    queryKey: ['stats'],
    queryFn: api.getStats,
  })
}

export function useUpdateCollection(setCode: string) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: ({
      cardId, owned, edition, condition, isUltimate, language, notes,
    }: { cardId: number; owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean; language?: number | null; notes?: string | null }) =>
      api.updateCollection(cardId, { owned, edition, condition, isUltimate, language, notes }),
    onSettled: (_data, _err, vars) => {
      queryClient.invalidateQueries({ queryKey: ['cards', vars.cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets', setCode, 'cards'] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
      queryClient.invalidateQueries({ queryKey: ['stats'] })
    },
  })
}

export function useUpdateCardDetail(cardId: number) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (data: { owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean; language?: number | null; notes?: string | null }) =>
      api.updateCollection(cardId, data),
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['cards', cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
      queryClient.invalidateQueries({ queryKey: ['stats'] })
    },
  })
}

export function useUploadPhoto(setCode: string) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ cardId, file }: { cardId: number; file: File }) =>
      api.uploadPhoto(cardId, file),
    onSuccess: (_data, vars) => {
      queryClient.invalidateQueries({ queryKey: ['sets', setCode, 'cards'] })
      queryClient.invalidateQueries({ queryKey: ['cards', vars.cardId] })
    },
  })
}

export function useDeletePhoto(setCode: string) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ cardId, photoId }: { cardId: number; photoId: number }) =>
      api.deletePhoto(cardId, photoId),
    onSuccess: (_data, vars) => {
      queryClient.invalidateQueries({ queryKey: ['sets', setCode, 'cards'] })
      queryClient.invalidateQueries({ queryKey: ['cards', vars.cardId] })
    },
  })
}

export function useUploadPhotoForCard(cardId: number) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (file: File) => api.uploadPhoto(cardId, file),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['cards', cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
    },
  })
}

export function useDeletePhotoForCard(cardId: number) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (photoId: number) => api.deletePhoto(cardId, photoId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['cards', cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
    },
  })
}
