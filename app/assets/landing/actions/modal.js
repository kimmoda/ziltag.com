export function openModal(name, payload={}) {
  payload.mode = payload.mode || 'normal'
  return {
    type: 'OPEN_MODAL',
    name, ...payload
  }
}

export function closeModal() {
  return {
    type: 'CLOSE_MODAL'
  }
}
