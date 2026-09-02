import { Field, ID, ObjectType } from '@nestjs/graphql';
import { Skill } from '../skill/skill.model.js';
import { Experience } from '../experience/experience.model.js';
import { Project } from '../project/project.model.js';
import { Link } from '../link/link.model.js';

@ObjectType('User', {
  description: 'Users table. This is the main user table.',
})
export class User {
  @Field(() => ID)
  id: string;

  @Field()
  login: string;

  @Field()
  email: string;

  @Field(() => String, { nullable: true })
  firstName?: string | null;

  @Field(() => String, { nullable: true })
  lastName?: string | null;

  @Field(() => String, { nullable: true })
  phone?: string | null;

  @Field(() => String, { nullable: true })
  bio?: string | null;

  @Field(() => [Skill])
  skills: Skill[];

  @Field(() => [Experience])
  experiences: Experience[];

  @Field(() => [Project])
  projects: Project[];

  @Field(() => [Link])
  links: Link[];

  @Field()
  createdAt: Date;

  @Field()
  updatedAt: Date;
}
