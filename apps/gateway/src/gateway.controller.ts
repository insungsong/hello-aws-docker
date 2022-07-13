import { Controller, Get } from '@nestjs/common';
import { GatewayService } from './gateway.service';

@Controller()
export class GatewayController {
  constructor(private readonly helloAwsDockerService: GatewayService) {}

  @Get()
  getHello(): string {
    return this.helloAwsDockerService.getHello();
  }
}
