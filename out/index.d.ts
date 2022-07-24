/// <reference types="@rbxts/types" />
/// <reference types="@rbxts/compiler-types" />
interface Box {
    created: number;
    box: TextBox;
}
export declare const boxes: Box[];
export declare const createText: (text: string, noPush: boolean) => TextBox;
export interface Command {
    name: string;
    description: string;
    aliases: string[];
    func: Callback;
    arguments: string[];
}
export declare const addCommand: (command: Command) => void;
export declare const addProvider: (provider: string, callback: Callback) => void;
export declare const filterRichText: (text: string) => string;
export {};
