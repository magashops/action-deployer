# LTH - Action Deployer

```yaml
      - name: Deploy stage Development with PHP-Deployer
        uses: magashops/action-deployer@v1
        with:
          args: "deploy --file=./.deployment/deploy.php stage=development -vvv"
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
```
