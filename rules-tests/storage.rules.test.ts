import { readFileSync } from 'node:fs';
import { RulesTestEnvironment, assertFails, assertSucceeds, initializeTestEnvironment } from '@firebase/rules-unit-testing';
import { ref, uploadBytes } from 'firebase/storage';
import { afterAll, beforeAll, describe, it } from 'vitest';

let env: RulesTestEnvironment;
beforeAll(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-falih',
    storage: { rules: readFileSync('../storage.rules', 'utf8') },
  });
});
afterAll(async () => env.cleanup());

const jpeg = (bytes = 1000) => new Uint8Array(bytes);
const up = (ctx: ReturnType<RulesTestEnvironment['authenticatedContext']>, path: string, data: Uint8Array, contentType = 'image/jpeg') =>
  uploadBytes(ref(ctx.storage(), path), data, { contentType });

describe('profile images', () => {
  it('owner can upload an image under 2 MB', () => assertSucceeds(up(env.authenticatedContext('alice'), 'user_profile_images/alice', jpeg())));
  it("cannot upload into someone else's path", () => assertFails(up(env.authenticatedContext('alice'), 'user_profile_images/bob', jpeg())));
  it('cannot upload a non-image', () => assertFails(up(env.authenticatedContext('alice'), 'user_profile_images/alice', jpeg(), 'text/html')));
  it('cannot upload 2 MB or more', () => assertFails(up(env.authenticatedContext('alice'), 'user_profile_images/alice', jpeg(2 * 1024 * 1024 + 1))));
  it('anonymous cannot upload', () => assertFails(up(env.unauthenticatedContext(), 'user_profile_images/alice', jpeg())));
  it('cannot write anywhere else in the bucket', () => assertFails(up(env.authenticatedContext('alice'), 'anything/else.jpg', jpeg())));
});
