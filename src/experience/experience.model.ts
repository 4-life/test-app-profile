import { Field, ID, ObjectType } from '@nestjs/graphql';

@ObjectType('Experience', {
  description:
    'Experiences table. A single work experience entry belonging to a user.',
})
export class Experience {
  @Field(() => ID)
  id: string;

  @Field()
  company: string;

  @Field()
  position: string;

  @Field()
  startDate: Date;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => [String])
  achievements: string[];
}
