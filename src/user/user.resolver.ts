import { Args, ID, Parent, Query, ResolveField, Resolver } from '@nestjs/graphql';
import type { User as PrismaUser } from '../generated/prisma/client.js';
import { PrismaService } from '../prisma/prisma.service.js';
import { User } from './user.model.js';
import { Skill } from '../skill/skill.model.js';
import { Experience } from '../experience/experience.model.js';
import { Project } from '../project/project.model.js';
import { Link } from '../link/link.model.js';

@Resolver(() => User)
export class UserResolver {
  constructor(private readonly prisma: PrismaService) {}

  @Query(() => [User])
  async users(): Promise<PrismaUser[]> {
    return this.prisma.user.findMany();
  }

  @Query(() => User, { nullable: true })
  async user(
    @Args('id', { type: () => ID }) id: string,
  ): Promise<PrismaUser | null> {
    return this.prisma.user.findUnique({ where: { id } });
  }

  @ResolveField(() => [Skill])
  async skills(@Parent() user: PrismaUser): Promise<Skill[]> {
    return this.prisma.skill.findMany({ where: { userId: user.id } });
  }

  @ResolveField(() => [Experience])
  async experiences(@Parent() user: PrismaUser): Promise<Experience[]> {
    return this.prisma.experience.findMany({ where: { userId: user.id } });
  }

  @ResolveField(() => [Project])
  async projects(@Parent() user: PrismaUser): Promise<Project[]> {
    return this.prisma.project.findMany({ where: { userId: user.id } });
  }

  @ResolveField(() => [Link])
  async links(@Parent() user: PrismaUser): Promise<Link[]> {
    return this.prisma.link.findMany({ where: { userId: user.id } });
  }
}
