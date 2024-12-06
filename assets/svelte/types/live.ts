type Cb = (reply:any, ref:any) =>  void

export type Live = {
    pushEvent(event: string, payload: unknown, cb?:Cb)
    pushEventTo(selectorOrTarget: unknown, event: string, payload: unknown, cb?:Cb)
    handleEvent(event: string, cb?: (payload: unknown) => void)
    upload(name: string, files: File[])
    uploadTo(selectorOrTarget: unknown, name: string, files: File[])
}