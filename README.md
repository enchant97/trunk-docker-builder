# Trunk Docker Builder
A Docker container for building a app using [trunk](https://trunkrs.dev/), supporting installing node requirements using [pnpm](https://pnpm.io/).

## Requirements
- x86_64
- Docker

## Usage
1. Pull container
2. Configure environment variables
3. Mount project source to /app
4. Run container
5. Get build output from /app

### Environment Variables
| Name     | Description                 | Default |
| :------- | :-------------------------- | :------ |
| PNPM_PRE | install packages using pnpm | true    |

### Build Args
- RUST_VERSION=1.67
- TRUNK_VERSION=^0.16.0
- USER_ID=1000
- GROUP_ID=1000
