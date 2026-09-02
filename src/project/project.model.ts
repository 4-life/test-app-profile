import { Field, ID, ObjectType } from '@nestjs/graphql';

@ObjectType('Project', {
  description: 'Projects table. A single project belonging to a user.',
})
export class Project {
  @Field(() => ID)
  id: string;

  @Field()
  name: string;

  @Field(() => String, { nullable: true })
  description?: string | null;

  @Field()
  url: string;
}
