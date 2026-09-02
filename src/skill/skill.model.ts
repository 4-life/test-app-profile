import { Field, ID, ObjectType } from '@nestjs/graphql';

@ObjectType('Skill', {
  description: 'Skills table. A single skill belonging to a user.',
})
export class Skill {
  @Field(() => ID)
  id: string;

  @Field()
  name: string;
}
