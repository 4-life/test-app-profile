import { Field, ID, ObjectType } from '@nestjs/graphql';

@ObjectType('Link', {
  description: 'Links table. A single professional link belonging to a user.',
})
export class Link {
  @Field(() => ID)
  id: string;

  @Field()
  label: string;

  @Field()
  url: string;
}
